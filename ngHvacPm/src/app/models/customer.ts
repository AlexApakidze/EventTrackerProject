import { ContactInfo } from "./contact-info";

export class Customer {
  id: number;
company:string;
contactInfo: ContactInfo;

  constructor(
    id: number =0,
    company:string ='',
    contactInfo: ContactInfo= new ContactInfo()
  ){
    this.id = id;
this.company=company;
this.contactInfo=contactInfo;
  }
}
