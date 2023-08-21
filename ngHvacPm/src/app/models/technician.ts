import { ContactInfo } from "./contact-info";
import { HvacPm } from "./hvac-pm";

export class Technician {
  id: number;
  contactInfo: ContactInfo;
  accounts: HvacPm[];


  constructor(
    id: number =0,
    contactInfo: ContactInfo = new ContactInfo(),
    accounts:HvacPm[]


  ){
    this.id = id;
    this.contactInfo=contactInfo;
    this.accounts=accounts;

  }
}
