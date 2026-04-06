package com.example.zadanie3.service

import org.springframework.stereotype.Service

@Service
class Authorization {
    private val users = mapOf(
        "Test1" to "password1",
        "Test2" to "password2",
        "Test3" to "password3"
    )

    fun authenticate(username: String, password: String): Boolean {
        return users[username] == password
    }

}
