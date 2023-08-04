package com.skilldistillery.hvacpm.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.hvacpm.entities.HvacPm;

class HvacPmTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private HvacPm pm;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAHvacPm");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		pm = em.find(HvacPm.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		pm = null;
	}

	@Test
	void test() {
		assertNotNull(pm);
		assertEquals(1, pm.getQuarter());
	}

}
