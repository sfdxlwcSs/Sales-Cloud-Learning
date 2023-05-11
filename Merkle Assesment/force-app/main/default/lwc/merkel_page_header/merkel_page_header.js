/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 11-05-2023
 * @last modified by  : Somnath Sharma
**/
import { LightningElement, api } from 'lwc';

export default class Merkel_page_header extends LightningElement {

    @api header_name = 'Product Order';
    @api icon_name = 'standard:product_item_transaction';
    @api description = 'Product Order List'
}