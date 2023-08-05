package com.skilldistillery.hvacpm.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String company;
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@OneToOne
	@JoinColumn(name="phone_number_id")
	private PhoneNumber phoneNumber;
	
	@JsonIgnore
	@OneToMany(mappedBy = "customer")
	private List<HvacPm> pms;

	
	
	public Customer() {
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

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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

	public List<HvacPm> getPms() {
		return pms;
	}

	public void setPms(List<HvacPm> pms) {
		this.pms = pms;
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
		Customer other = (Customer) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", name=" + name + ", company=" + company + ", address=" + address
				+ ", phoneNumber=" + phoneNumber + ", pms=" + pms.size() + "]";
	}
	
	
}
