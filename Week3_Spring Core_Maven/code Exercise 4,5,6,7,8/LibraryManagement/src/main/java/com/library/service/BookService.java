package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;


    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("Constructor injection used.");
    }


    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("Setter injection used.");
    }

    public void addBook(String title) {
        System.out.println("Adding book...");
        bookRepository.saveBook(title);
    }
}
