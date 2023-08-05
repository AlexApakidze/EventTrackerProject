package com.skilldistillery.hvacpm.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class Technician {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private Address address;
	
	private PhoneNumber phoneNumber;
	
	private List<HvacPm> accounts;
	
	public Technician() {
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public PhoneNumber getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(PhoneNumber phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public List<HvacPm> getAccounts() {
		return accounts;
	}
	public void setAccounts(List<HvacPm> accounts) {
		this.accounts = accounts;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Technician other = (Technician) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "Technician [id=" + id + ", name=" + name + ", address=" + address + ", phoneNumber=" + phoneNumber
				+ ", accounts=" + accounts.size() + "]";
	}
	
	
}