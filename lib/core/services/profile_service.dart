import 'package:book_swap/features/books/data/models/book.dart';
import 'package:book_swap/features/auth/data/models/user.dart';

class ProfileService {

  Future<User> getUser() async {
    return User(id: '1', name: 'Arthur Martins', email: 'arthur@example.com', avatar: 'https://i.pravatar.cc/150?img=1');
  }

  Future<List<Book>> getUserBooks() async {
    return [
      Book(id: '1', title: 'Clean Code', author: 'Robert C. Martin', genre: 'Programming', year: 2008, pages: 464, synopsis: 'A handbook of agile software craftsmanship', imagePath: 'https://via.placeholder.com/200', ownerId: '1', ownerName: 'Arthur Martins', status: 'available', ownerAvatar: 'https://i.pravatar.cc/150?img=1', publisher: 'Prentice Hall'),
      Book(id: '2', title: 'Flutter na Prática', author: 'Dev BR', genre: 'Programming', year: 2022, pages: 320, synopsis: 'Aprenda Flutter do zero', imagePath: 'https://via.placeholder.com/200', ownerId: '1', ownerName: 'Arthur Martins', status: 'available', ownerAvatar: 'https://i.pravatar.cc/150?img=1', publisher: 'Dev BR'),
    ];
  }

  Future<List<Book>> getSoldBooks() async {
    return [
      Book(id: '3', title: 'Algoritmos', author: 'Cormen', genre: 'Computer Science', year: 2009, pages: 1312, synopsis: 'Introduction to Algorithms', imagePath: 'https://via.placeholder.com/200', ownerId: '1', ownerName: 'Arthur Martins', status: 'sold', ownerAvatar: 'https://i.pravatar.cc/150?img=1', publisher: 'MIT Press'),
    ];
  }
}
