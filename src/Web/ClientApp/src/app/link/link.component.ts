import { Component, TemplateRef, OnInit } from '@angular/core';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';
import { LinkItemsClient,
  LinkItemDto, LookupDto,
  CreateLinkItemCommand, UpdateLinkItemCommand, UpdateLinkItemDetailCommand
} from '../web-api-client';

@Component({
  selector: 'app-link-component',
  templateUrl: './link.component.html',
  styleUrls: ['./link.component.scss']
})
export class LinkComponent implements OnInit {
  debug = false;
  priorityLevels: LookupDto[];
  selectedItem: LinkItemDto;
  newListEditor: any = {};
  listOptionsEditor: any = {};
  itemDetailsEditor: any = {};
  newListModalRef: BsModalRef;
  listOptionsModalRef: BsModalRef;
  deleteListModalRef: BsModalRef;
  itemDetailsModalRef: BsModalRef;

  constructor(
    private itemsClient: LinkItemsClient,
    private modalService: BsModalService
  ) {}

  ngOnInit(): void {
    
  }

  // Items
  showItemDetailsModal(template: TemplateRef<any>, item: LinkItemDto): void {
    this.selectedItem = item;
    this.itemDetailsEditor = {
      ...this.selectedItem
    };

    this.itemDetailsModalRef = this.modalService.show(template);
  }

  updateItemDetails(): void {
    const item = this.itemDetailsEditor as UpdateLinkItemDetailCommand;
    this.itemsClient.updateLinkItemDetail(this.selectedItem.id, item).subscribe(
      () => {
        if (this.selectedItem.listId !== this.itemDetailsEditor.listId) {
          this.selectedList.items = this.selectedList.items.filter(
            i => i.id !== this.selectedItem.id
          );
          const listIndex = this.lists.findIndex(
            l => l.id === this.itemDetailsEditor.listId
          );
          this.selectedItem.listId = this.itemDetailsEditor.listId;
          this.lists[listIndex].items.push(this.selectedItem);
        }

        this.selectedItem.priority = this.itemDetailsEditor.priority;
        this.selectedItem.note = this.itemDetailsEditor.note;
        this.itemDetailsModalRef.hide();
        this.itemDetailsEditor = {};
      },
      error => console.error(error)
    );
  }

  addItem() {
    const item = {
      id: 0,
      listId: this.selectedList.id,
      priority: this.priorityLevels[0].id,
      title: '',
      done: false
    } as LinkItemDto;

    this.selectedList.items.push(item);
    const index = this.selectedList.items.length - 1;
    this.editItem(item, 'itemTitle' + index);
  }

  editItem(item: LinkItemDto, inputId: string): void {
    this.selectedItem = item;
    setTimeout(() => document.getElementById(inputId).focus(), 100);
  }

  updateItem(item: LinkItemDto, pressedEnter: boolean = false): void {
    const isNewItem = item.id === 0;

    if (!item.title.trim()) {
      this.deleteItem(item);
      return;
    }

    if (item.id === 0) {
      this.itemsClient
          .createLinkItem({ title: item.title, listId: this.selectedList.id } as CreateLinkItemCommand)
        .subscribe(
          result => {
            item.id = result;
          },
          error => console.error(error)
        );
    } else {
        this.itemsClient.updateLinkItem(item.id, item as UpdateLinkItemCommand).subscribe(
        () => console.log('Update succeeded.'),
        error => console.error(error)
      );
    }

    this.selectedItem = null;

    if (isNewItem && pressedEnter) {
      setTimeout(() => this.addItem(), 250);
    }
  }

  deleteItem(item: LinkItemDto) {
    if (this.itemDetailsModalRef) {
      this.itemDetailsModalRef.hide();
    }

    if (item.id === 0) {
      const itemIndex = this.selectedList.items.indexOf(this.selectedItem);
      this.selectedList.items.splice(itemIndex, 1);
    } else {
      this.itemsClient.deleteLinkItem(item.id).subscribe(
        () =>
          (this.selectedList.items = this.selectedList.items.filter(
            t => t.id !== item.id
          )),
        error => console.error(error)
      );
    }
  }
}
