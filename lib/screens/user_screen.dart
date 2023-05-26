import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();

  List<User> _users = [];
  late User _selectedUser;
  bool _isLoading = false;
  UserRole? _selectedRole;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final users = await _userService.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  void selectUser(User user) {
    setState(() {
      _selectedUser = user;
    });
  }

  Future<void> createUser(User user) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final createdUser = await _userService.createUser(user);
      setState(() {
        _users.add(createdUser);
        _isLoading = false;
      });
      Navigator.of(context).pop(); // Close the create user modal
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  Future<void> updateUser(User user) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updatedUser = await _userService.updateUser(user);
      setState(() {
        final index = _users.indexWhere((u) => u.id == updatedUser.id);
        if (index >= 0) {
          _users[index] = updatedUser;
        }
        _isLoading = false;
      });
      Navigator.of(context).pop(); // Close the update user modal
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  Future<void> deleteUser(User user) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _userService.deleteUser(user.id);
      setState(() {
        _users.remove(user);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  void showCreateUserModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _name = '';
    String _email = '';
    String _password = '';
    String _phone = '';
    // UserRole _role;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create User'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    // You can add additional email validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    // You can add additional password validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _password = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a phone number';
                    }
                    // You can add additional phone number validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value ?? '';
                  },
                ),
                DropdownButtonFormField<UserRole>(
                  value: _selectedRole,
                  onChanged: (UserRole? value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  items: UserRole.values.map((UserRole role) {
                    return DropdownMenuItem<UserRole>(
                      value: role,
                      child: Text(role.toString().split('.').last),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Role',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newUser = User(
                          id: int.parse(Uuid().v4().replaceAll('-', ''),
                              radix: 16),
                          name: _name,
                          email: _email,
                          password: _password,
                          phone: _phone,
                          role: _selectedRole);
                      createUser(newUser);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Create'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showUpdateUserModal(BuildContext context, User user) {
    final _formKey = GlobalKey<FormState>();
    String _name = user.name;
    String _email = user.email;
    String _password = user.password;
    String _phone = user.phone;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: _name,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  initialValue: _email,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    // You can add additional email validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  initialValue: _password,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    // You can add additional password validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _password = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  initialValue: _phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a phone number';
                    }
                    // You can add additional phone number validation logic here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value ?? '';
                  },
                ),
                DropdownButtonFormField<UserRole>(
                  value: _selectedRole,
                  onChanged: (UserRole? value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  items: UserRole.values.map((UserRole role) {
                    return DropdownMenuItem<UserRole>(
                      value: role,
                      child: Text(role.toString().split('.').last),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Role',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final updatedUser = User(
                        id: user.id,
                        name: _name,
                        email: _email,
                        password: _password,
                        phone: _phone,
                        role: _selectedRole,
                      );
                      updateUser(updatedUser);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = _users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    selectUser(user);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateUserModal(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            showUpdateUserModal(context, _selectedUser);
          } else if (index == 1) {
            deleteUser(_selectedUser);
          }
        },
      ),
    );
  }
}
