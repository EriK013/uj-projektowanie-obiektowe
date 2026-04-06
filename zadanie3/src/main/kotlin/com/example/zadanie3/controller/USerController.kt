package com.example.zadanie3.controller
import com.example.zadanie3.model.User
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")

class UserController {
    private val users = listOf(
        User(1, "Test1"),
        User(2, "Test2"),
        User(3, "Test3")
    )

    @GetMapping("/users")
    fun getUsers(): List<User> {
        return users
    }
}