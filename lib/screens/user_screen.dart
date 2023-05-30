import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/user_service.dart';
import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

const List<String> list = <String>['Owner', 'Tenant'];

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();

  List<dynamic> _users = [];
  late User _selectedUser;
  bool _isLoading = false;
  String _selectedRole = list.first;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print("34");
      final users = await _userService.getUsers();
      print("36");
      print(users);
      print("38");
      print(_users);
      setState(() {
        _users = users;
        print("42");
        print(_users);
        _isLoading = false;
      });
      print("46");
      print(_users);
      // print(_users[0]['name']);
      // print(_users[1].email);
      // print(_users[2].phone);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch users.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      throw Exception('Failed to fetch Users: $error');
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
      print("89");
      print(_users);
      setState(() {
        _users.add(createdUser);
        _isLoading = false;
      });
      print("95");
      print(_users);
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
      final updatedUser = await _userService.updateUser(user.id, user);
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

  // Future<void> _deleteUser(int id) async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     await _userService.deleteUser(id);
  //     setState(() {
  //       _users.remove(id);
  //       _isLoading = false;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // Handle error
  //   }
  // }

  Future<void> _deleteUser(int id) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() {
                _isLoading = true;
              });

              try {
                await _userService.deleteUser(id);
                setState(() {
                  _isLoading = false;
                });
                _fetchUsers();
              } catch (e) {
                // Handle error
                setState(() {
                  _isLoading = false;
                });
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to delete user.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showCreateUserModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _name = '';
    String _email = '';
    String _password = '';
    String _phone = '';
    String finalRole = list.first;

    // finalRole _role;

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
                // DropdownButtonFormField<finalRole>(
                //   value: _selectedRole,
                //   onChanged: (finalRole? value) {
                //     setState(() {
                //       _selectedRole = value;
                //     });
                //   },
                //   items: finalRole.values.map((finalRole role) {
                //     return DropdownMenuItem<finalRole>(
                //       value: role,
                //       child: Text(role.toString().split('.').last),
                //     );
                //   }).toList(),
                //   decoration: InputDecoration(
                //     labelText: 'Role',
                //   ),
                // ),
                DropdownButtonFormField<String>(
                  value: finalRole,
                  hint: Text('User Type'),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      finalRole = newValue!;
                      // Handle selected option
                      print('Selected option: $finalRole');
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.deepPurple,
                  ),
                  dropdownColor: Colors.deepPurple.shade50,
                  decoration: InputDecoration(
                    labelText: "User Type",
                    // prefixIcon: Icon(
                    //   Icons.accessibility_new_rounded,
                    //   color: Colors.deepPurple,
                    // )
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newUser = User(
                          id: 123,
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
    String finalRole = user.role;

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
                // DropdownButtonFormField<finalRole>(
                //   value: _selectedRole,
                //   onChanged: (finalRole? value) {
                //     setState(() {
                //       _selectedRole = value;
                //     });
                //   },
                //   items: finalRole.values.map((finalRole role) {
                //     return DropdownMenuItem<finalRole>(
                //       value: role,
                //       child: Text(role.toString().split('.').last),
                //     );
                //   }).toList(),
                //   decoration: InputDecoration(
                //     labelText: 'Role',
                //   ),
                // ),
                DropdownButtonFormField<String>(
                  value: finalRole,
                  hint: Text('User Type'),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      finalRole = newValue!;
                      // Handle selected option
                      print('Selected option: $finalRole');
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.deepPurple,
                  ),
                  dropdownColor: Colors.deepPurple.shade50,
                  decoration: InputDecoration(
                    labelText: "User Type",
                    // prefixIcon: Icon(
                    //   Icons.accessibility_new_rounded,
                    //   color: Colors.deepPurple,
                    // )
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
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  trailing: Text(user['role']),
                  onTap: () {
                    selectUser(user);
                  },
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () async {
                  //     await _deleteUser(user.id);
                  //   },
                  // ),
                );
              },
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showCreateUserModal(context);
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          ).then((value) {
            if (value == true) {
              _fetchUsers();
            }
          });
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
            _deleteUser(_selectedUser.id);
          }
        },
      ),
    );
  }
}

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  UserService _userService = UserService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String finalRole = list.first;
  List<User> _users = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: finalRole,
                    hint: Text('User Type'),
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        finalRole = newValue!;
                        // Handle selected option
                        print('Selected option: $finalRole');
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepPurple,
                    ),
                    dropdownColor: Colors.deepPurple.shade50,
                    decoration: InputDecoration(
                      labelText: "User Type",
                      // prefixIcon: Icon(
                      //   Icons.accessibility_new_rounded,
                      //   color: Colors.deepPurple,
                      // )
                    ),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      User newUser = User(
                        id: 123,
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phone: _phoneController.text,
                        role: finalRole,
                      );
                      _createUser(newUser);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _createUser(User user) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
    final role = finalRole;

    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter name and email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // final user = User(
      //     id: 12,
      //     name: name,
      //     email: email,
      //     password: password,
      //     phone: phone,
      //     role: role);
      print(user.id);
      print(user.name);
      print(user.email);
      print(user.password);
      print(user.phone);
      print(user.role.toLowerCase());
      // final response = await _userService.createUser(user);
      print("697");
      // print(_userService.createUser(user));
      dynamic data = await _userService.createUser(user);
      print("700");
      // print(_userService.createUser(user));
      if (data != null) {
        User newUser = User.fromJson(data);
        setState(() {
          _users.add(newUser);
        });
      } else {
        print('Failed to create user: Invalid response');
      }

      setState(() {
        _isLoading = false;
      });
      // if (response == true) {
      Navigator.pop(context, true);
      // }
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create user 715.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
