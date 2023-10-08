import UIKit

class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool

    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }

    func markAsBorrowed() {
        isBorrowed = true
    }

    func markAsReturned() {
        isBorrowed = false
    }
}
class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]

    init(ownerId: Int, name: String) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = []
    }

    func borrowBook(_ book: Book) {
        borrowedBooks.append(book)
    }

    func returnBook(_ book: Book) {
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            borrowedBooks.remove(at: index)
        }
    }
}
class Library {
    var books: [Book]
    var owners: [Owner]

    init() {
        self.books = []
        self.owners = []
    }

    func addBook(_ book: Book) {
        books.append(book)
    }

    func addOwner(_ owner: Owner) {
        owners.append(owner)
    }

    func getAllBooks() -> [Book] {
        return books
    }

    func getBorrowedBooks() -> [Book] {
        return books.filter { $0.isBorrowed }
    }

    func findOwnerByID(_ ownerID: Int) -> Owner? {
        return owners.first { $0.ownerId == ownerID }
    }

    func findBorrowedBooksByOwner(_ owner: Owner) -> [Book] {
        return owner.borrowedBooks
    }

    func lendBook(_ book: Book, to owner: Owner) {
        if !book.isBorrowed {
            owner.borrowBook(book)
            book.markAsBorrowed()
        }
    }

    func returnBook(_ book: Book, from owner: Owner) {
        if let index = owner.borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            owner.borrowedBooks.remove(at: index)
            book.markAsReturned()
        }
    }
}


let library = Library()

let book1 = Book(bookID: 1, title: "დედაენა", author: "იაკობ გოგებაშვილი", isBorrowed: false)
let book2 = Book(bookID: 2, title: "შუშანიკი", author: "იაკობ ხუცესი", isBorrowed: false)
let book3 = Book(bookID: 3, title: "ვეფხისტყაოსანი", author: "შოთა რუსთაველი", isBorrowed: false)

library.addBook(book1)
library.addBook(book2)
library.addBook(book3)

let owner1 = Owner(ownerId: 1, name: "ნანა")
let owner2 = Owner(ownerId: 2, name: "სანდრო")

library.addOwner(owner1)
library.addOwner(owner2)

library.lendBook(book1, to: owner1)
library.lendBook(book2, to: owner1)
library.lendBook(book3, to: owner2)

let allBooks = library.getAllBooks()
let borrowedBooks = library.getBorrowedBooks()
let owner1Books = library.findBorrowedBooksByOwner(owner1)
let owner2Books = library.findBorrowedBooksByOwner(owner2)

print("ყველა წიგნი:")
for book in allBooks {
    print("\(book.title), მდგომარეობა: \(book.isBorrowed ? "ხელმისაწვდომი" : "ხარისხიანია")")
}

print("\nწაღებული წიგნები:")
for book in borrowedBooks {
    print("\(book.title) ეკუთვნის \(owner1.name)ს" )
}

print("\n\(owner1.name)ს წაღებული წიგნები:")
for book in owner1Books {
    print(book.title)
}

print("\n\(owner2.name)ს წაღებული წიგნები:")
for book in owner2Books {
    print(book.title)
}

print("-------------------------------------------------------------------")


//Task2

class Product {
    var productID: Int
    var name: String
    var price: Double

    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

class Cart {
    var cartID: Int
    var items: [Product]

    init(cartID: Int) {
        self.cartID = cartID
        self.items = []
    }

    func addItem(_ product: Product) {
        items.append(product)
    }

    func removeItem(by productID: Int) {
        if let index = items.firstIndex(where: { $0.productID == productID }) {
            items.remove(at: index)
        }
    }

    func calculateTotalPrice() -> Double {
        let totalPrice = items.reduce(0.0) { $0 + $1.price }
        return totalPrice
    }
}

class User {
    var userID: Int
    var username: String
    var cart: Cart

    init(userID: Int, username: String, cartID: Int) {
        self.userID = userID
        self.username = username
        self.cart = Cart(cartID: cartID)
    }

    func addToCart(_ product: Product) {
        cart.addItem(product)
    }

    func removeFromCart(by productID: Int) {
        cart.removeItem(by: productID)
    }

    func checkout() -> Double {
        let totalPrice = cart.calculateTotalPrice()
        cart.items.removeAll()
        return totalPrice
    }
}

// პროდუქტების შექმნა
let product1 = Product(productID: 1, name: "სზამთრო", price: 10.0)
let product2 = Product(productID: 2, name: "ანანასი", price: 15.0)

// იუზერების შექმნა
let user1 = User(userID: 1, username: "სანდრო", cartID: 1)
let user2 = User(userID: 2, username: "ნანა", cartID: 2)

// პროდუქტების დამატება კალათებში
user1.addToCart(product1)
user1.addToCart(product2)
user2.addToCart(product2)

// ყველა item-ის ფასის დაბეჭდვა კალათებიდან
print("\(user1.username)ს კალათის ფასია: \(user1.cart.calculateTotalPrice()) ლარი")
print("\(user2.username)ს კალათის ფასია: \(user2.cart.calculateTotalPrice()) ლარი")

// ჩექაუთი
let totalPriceUser1 = user1.checkout()
let totalPriceUser2 = user2.checkout()

print("\(user1.username)მ გადახდა \(totalPriceUser1) ლარი")
print("\(user2.username)მ გადახდა \(totalPriceUser2) ლარი")



