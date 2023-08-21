export class ContactInfo {
  id: number;
  name: string;
  phoneNumber: string;
  street: string;
  city: string;
  state: string;
  zipcode: string;

  constructor(
    id: number = 0,
    name: string = '',
    phoneNumber: string = '',
    street: string = '',
    city: string = '',
    state: string = '',
    zipcode: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.street = street;
    this.city = city;
    this.state = state;
    this.zipcode = zipcode;
  }
}
