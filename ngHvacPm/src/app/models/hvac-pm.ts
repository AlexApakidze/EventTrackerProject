import { ContactInfo } from './contact-info';
import { Customer } from './customer';
import { Equipment } from './equipment';
import { Task } from './task';
import { Technician } from './technician';

export class HvacPm {
  id: number;
  locationInfo: ContactInfo;
  quarter: number;
  customer: Customer;
  tasks: Task[];
  techs: Technician[];
  contacts: ContactInfo[];
  units: Equipment[];
  completed: boolean;

  constructor(
    id: number = 0,
    locationInfo: ContactInfo,
    quarter: number = 0,
    customer: Customer,
    tasks: Task[],
    techs: Technician[],
    contacts: ContactInfo[],
    units: Equipment[],
    completed: boolean = false
  ) {
    this.id = id;
    this.locationInfo = locationInfo;
    this.quarter = quarter;
    this.customer = customer;
    this.tasks = tasks;
    this.techs = techs;
    this.contacts = contacts;
    this.units = units;
    this.completed = completed;
  }
}
