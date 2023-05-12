/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 12-05-2023
 * @last modified by  : Somnath Sharma
**/
import { LightningElement, wire, api } from 'lwc';
import Default_Image from '@salesforce/resourceUrl/NoProductImage';
import { isNotBlank, isBlank } from 'c/merkel_utility'
import Pre_Order from '@salesforce/label/c.Pre_Order';
import Button_Label from '@salesforce/label/c.Button_Label';

export default class Productcard extends LightningElement {

    default_product_url = Default_Image;
    @api product = {};
    url = '';
    label = {
        Pre_Order,
        Button_Label
    }
    quanity = 0;
    //if the width needs to be varied then
    @api card_width = '316px';



    handleClick(event) {

        let buttonClicked = event.currentTarget.dataset.buttonname;
        if (buttonClicked === this.label.Button_Label) {
            if (this.quanity === 0) {
                this.template.querySelector('c-custom-toast').showToast('warning', 'Please increase the QTY to add Product to cart.');
            }
            else {
                this.template.querySelector('c-custom-toast').showToast('success', this.quanity + ' - ' + event.currentTarget.dataset.productname + ' added to cart.');
            }

        } else {
            /**future scope */
        }
    }

    connectedCallback() {
        this.url = this.formImageurl();
        var css = this.template.host.style;
        css.setProperty('--modalWidth', this.card_width);

    }

    formImageurl() {
        let str = window.location.href;
        let url = '';
        if (Object.keys(this.product).length != 0) {
            if (isBlank(this.product.ProductImageUrl)) {
                url = this.default_product_url;
            }
            else {
                let formatUrl = str.substr(0, str.lastIndexOf('/s'));
                url = formatUrl + '/sfc/servlet.shepherd/version/renditionDownload?rendition=ORIGINAL_Png&versionId=' + this.product.ProductImageUrl;
            }
        }

        return url;
    }



    handleCustomEvent(event) {
        const quantity_added_to_cart = event.detail;
        this.quanity = quantity_added_to_cart;
    }

}