package com.example.zadanie3.controller
import com.example.zadanie3.model.User

import com.example.zadanie3.service.Authorization
import com.example.zadanie3.model.*
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")

class UserController {

    private val authorization = Authorization()
    
    private val users = listOf(
        User(1, "Test1"),
        User(2, "Test2"),
        User(3, "Test3")
    )

    @GetMapping("/users")
    fun getUsers(): List<User> {
        return users
    }

    @PostMapping("/login")
    fun login(@RequestBody loginRequest: LoginRequest): LoginResponse {
        val isAuthenticated = authorization.authenticate(loginRequest.username, loginRequest.password)
        return if (isAuthenticated) {
            LoginResponse(success = true, message = "Login successful")
        } else {
            LoginResponse(success = false, message = "Invalid username or password")
        }
    }
}