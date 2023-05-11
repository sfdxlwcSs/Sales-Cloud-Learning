/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 09-05-2023
 * @last modified by  : Somnath Sharma
**/
import { LightningElement, wire } from 'lwc';

// getProducts() method in Merkel_ProductList Apex class
import getProducts from '@salesforce/apex/Merkel_ProductList.getProducts';

export default class Mekel_product2card_list extends LightningElement {

    products_data = [];
    error_array = [];
    show_spinner=true;

    @wire(getProducts)
    product_data({ error, data }) {
        if (data) {

        console.log("productData ====> " + JSON.stringify(data));
        this.process_data(data);

        } else if (error) {
            this.show_spinner=false;
            console.log("error to Load Default====> " + JSON.stringify(error));
            this.error_array.push(JSON.stringify(error));
             console.log("error to Load Default====> " +  this.error_array);
        }
    }
    get showErrPanel() {
        return this.error_array.length > 0 ? true : false;
    }

    process_data(data){
        this.products_data = data;
        this.show_spinner=this.products_data.length > 0 ? false : true;
    }
    
}