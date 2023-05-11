/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 08-05-2023
 * @last modified by  : Somnath Sharma
**/
import { LightningElement, api } from 'lwc';

export default class Merkel_error_panel extends LightningElement {
    /***error message passed from calling component */
    @api errormessagearray = [];
}