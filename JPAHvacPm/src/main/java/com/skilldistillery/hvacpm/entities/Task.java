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

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Task {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String todo;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "hvac_pm_task", joinColumns = @JoinColumn(name = "hvac_pm_id"), inverseJoinColumns = @JoinColumn(name = "pm_id"))
	private List<HvacPm> pms;

	public Task() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTodo() {
		return todo;
	}

	public void setTodo(String todo) {
		this.todo = todo;
	}

	public void addPm(HvacPm pm) {
		if(pms ==null) {pms = new ArrayList<>();}
		if( ! pms.contains(pm)) {
			pms.add(pm);
			pm.addTask(this);
		}
	}

	public void removePm(HvacPm pm) {
		if(pms!= null && pms.contains(pm)) {
			pms.remove(pm);
			pm.removeTask(this);
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
		Task other = (Task) obj;
		return id == other.id;
	}

}
