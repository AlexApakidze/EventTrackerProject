package com.skilldistillery.hvacpm.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Contact {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@OneToOne
	@JoinColumn(name="phone_number_id")
	private PhoneNumber phoneNumber;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "hvac_pm_contact", joinColumns = @JoinColumn(name = "hvac_pm_id"), inverseJoinColumns = @JoinColumn(name = "contact_id"))
	private List<HvacPm> pms;

	public Contact() {
		super();
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

	
	public void addPm(HvacPm pm) {
		if(pms ==null) {pms = new ArrayList<>();}
		if( ! pms.contains(pm)) {
			pms.add(pm);
			pm.addContact(this);
		}
	}

	public void removePm(HvacPm pm) {
		if(pms!= null && pms.contains(pm)) {
			pms.remove(pm);
			pm.removeContact(this);
		}
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
		Contact other = (Contact) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Contact [id=" + id + ", name=" + name + ", phoneNumber=" + phoneNumber + ", pms=" + pms.size() + "]";
	}
	
	
}
