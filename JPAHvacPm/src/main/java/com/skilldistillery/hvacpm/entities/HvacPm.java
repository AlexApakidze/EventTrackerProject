package com.skilldistillery.hvacpm.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "hvac_pm")
public class HvacPm {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private int quarter;
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@OneToOne
	@JoinColumn(name="customer_id")
	private Customer customer;

	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "hvac_pm_task", joinColumns = @JoinColumn(name = "task_id"), inverseJoinColumns = @JoinColumn(name = "hvac_pm_id"))
	private List<Task> tasks;

	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "hvac_pm_technician", joinColumns = @JoinColumn(name = "technician_id"), inverseJoinColumns = @JoinColumn(name = "hvac_pm_id"))
	private List<Technician> techs;

	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "hvac_pm_contact", joinColumns = @JoinColumn(name = "contact_id"), inverseJoinColumns = @JoinColumn(name = "hvac_pm_id"))
	private List<Contact> contacts;

	@JsonIgnore
	@OneToMany(mappedBy = "pm")
	public List<Equipment> units;

	public HvacPm() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuarter() {
		return quarter;
	}

	public void setQuarter(int quarter) {
		this.quarter = quarter;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<Task> getTasks() {
		return tasks;
	}

	public List<Equipment> getUnits() {
		return units;
	}

	public void setUnits(List<Equipment> units) {
		this.units = units;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}

	public List<Technician> getTechs() {
		return techs;
	}

	public void setTechs(List<Technician> techs) {
		this.techs = techs;
	}

	public List<Contact> getContacts() {
		return contacts;
	}

	public void setContacts(List<Contact> contacts) {
		this.contacts = contacts;
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
		HvacPm other = (HvacPm) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "HvacPm [id=" + id + ", quarter=" + quarter + ", address=" + address + ", customer=" + customer
				+ ", tasks=" + tasks.size() + ", techs=" + techs.size() + ", contacts=" + contacts.size() + "]";
	}

}
