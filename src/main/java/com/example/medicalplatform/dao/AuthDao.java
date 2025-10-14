package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.Admin;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.*;

public class AuthDao {

    public final EntityManagerFactory emf;
    public AuthDao(){
        emf = EmfUtil.getEntityManagerFactory();
    }
    public String save(Admin admin){
            EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(admin);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            return e.getMessage();
        } finally {
            em.close();
        }
        return admin.getEmail();
    }
    public Admin findAdminByEmail(String email){
        EntityManager em = emf.createEntityManager();
       try {
           TypedQuery<Admin> query = em.createQuery("select u from Admin u where u.email = :email", Admin.class);
           query.setParameter("email",email);
           return query.getSingleResult();
       } catch (NoResultException e){
           return null;
       } finally {
           em.close();
       }
    }

}
