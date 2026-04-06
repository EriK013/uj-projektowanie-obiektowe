package com.example.zadanie3

import com.example.zadanie3.service.Authorization
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions.*

class AuthorizationTest {

    private val authService = Authorization()

    @Test
    fun `should authenticate valid user`() {
        assertTrue(authService.authenticate("Test1", "password1"))
        assertTrue(authService.authenticate("Test2", "password2"))
        assertTrue(authService.authenticate("Test3", "password3"))
    }

    @Test
    fun `should not authenticate invalid user`() {
        assertFalse(authService.authenticate("Test1", "wrongpassword"))
        assertFalse(authService.authenticate("UnknownUser", "password1"))
    }
}