package com.skilldistillery.hvacpm.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.hvacpm.entities.HvacPm;

public interface HvacPmRepository extends JpaRepository<HvacPm, Integer> {

}
