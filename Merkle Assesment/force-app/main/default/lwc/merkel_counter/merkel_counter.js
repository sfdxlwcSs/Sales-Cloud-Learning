/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 10-05-2023
 * @last modified by  : Somnath Sharma
**/
import { LightningElement } from 'lwc';

export default class Merkel_counter extends LightningElement {

    counter_value = 0;

    addTOCart(event) {
        this.counter_value += 1;
        this.handleChange(event);
    }
    removeFromCart(event) {
        if (this.counter_value != 0) {
            this.counter_value -= 1;
        }
        this.handleChange(event);
    }
    handleChange(event) {
        event.preventDefault();

        const selectEvent = new CustomEvent('myqtyevent', {
            detail: this.counter_value
        });
        this.dispatchEvent(selectEvent);
    }
}