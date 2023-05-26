import 'package:flutter/material.dart';
import 'package:housing_society_management/models/property.dart';
import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/property_service.dart';
import 'package:housing_society_management/services/user_service.dart';

class PropertyScreen extends StatefulWidget {
  final PropertyService propertyService = PropertyService();
  final UserService userService = UserService();

  // PropertyScreen({required this.propertyService, required this.userService});

  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  List<Property> properties = [];
  List<Property> filteredProperties = [];
  List<User> users = [];
  User? selectedOwner;
  String selectedPropertyType = 'All';
  PropertyType filterType = PropertyType.Flat;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProperties();
    fetchUsers();
    fetchAvailableProperties();
  }

  Future<void> fetchUsers() async {
    try {
      List<User> fetchedUsers = await widget.userService.getUsers();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch users: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> fetchProperties() async {
    try {
      final List<Property> fetchedProperties =
          await widget.propertyService.fetchProperties();
      setState(() {
        properties = fetchedProperties;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch properties: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Future<void> filterPropertiesByType(String type) async {
  //   try {
  //     final List<Property> propertiesFilter =
  //         await widget.propertyService.filterPropertiesByType(type);
  //     setState(() {
  //       filterType = type;
  //       filteredProperties =
  //           properties.where((property) => property.type == type).toList();

  //       properties = propertiesFilter;
  //       selectedPropertyType = type;
  //     });
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to filter properties: $e'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> fetchAvailableProperties() async {
    try {
      final List<Property> availableProperties =
          await widget.propertyService.fetchAvailableProperties();
      setState(() {
        properties = availableProperties;
        selectedPropertyType = 'Available';
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch available properties: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> getPropertyById(int id) async {
    try {
      final Property property =
          await widget.propertyService.fetchPropertyById(id);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Property Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Title: ${property.title}'),
                Text('Description: ${property.description}'),
                Text('Price: Rs. ${property.price.toStringAsFixed(2)}'),
                Text('Type: $filterType'),
                // Display other property details as needed
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch property details: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // // Generate a unique ID for a new property
  int _generateUniqueId() {
    // Implement your own logic to generate unique IDs
    // You can use a package like `uuid` or generate IDs based on the timestamp
    // For simplicity, we'll just use the current timestamp here
    return DateTime.now().millisecondsSinceEpoch;
  }

  // Future<void> addProperty(Property property) async {
  //   String title = _titleController.text;
  //   String type = _titleController.text;
  //   String description = _descriptionController.text;
  //   double price = double.tryParse(_priceController.text) ?? 0.0;

  //   Property property = Property(
  //     id: _generateUniqueId(),
  //     type: type,
  //     title: title,
  //     description: description,
  //     price: price,
  //   );

  //   try {
  //     await widget.propertyService.createProperty(property);
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Success'),
  //           content: Text('Property added successfully'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 fetchProperties();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to add property: $e'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> addProperty() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    Property property = Property(
      id: _generateUniqueId(),
      type: filterType,
      title: title,
      description: description,
      price: price,
      isAvailable: true,
      owner: selectedOwner,
    );

    try {
      await widget.propertyService.createProperty(property);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Property added successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchProperties();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add property: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void filterPropertiesByType(PropertyType? type) {
    setState(() {
      filterType = type!;
      filteredProperties =
          properties.where((property) => property.type == type).toList();
    });
  }

  Future<void> updateProperty(Property property) async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    property.title = title;
    property.description = description;
    property.price = price;
    try {
      await widget.propertyService.updateProperty(property);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Property updated successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchProperties();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update property: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> deleteProperty(int id) async {
    try {
      await widget.propertyService.deleteProperty(id);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Property deleted successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  fetchProperties();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete property: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Future<void> addProperty(Property property) async {
  //   try {
  //     await widget.propertyService.createProperty(property);
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Success'),
  //           content: Text('Property added successfully'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     fetchProperties();
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to add property: $e'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties List'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Filter by Type:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                DropdownButton<PropertyType>(
                  value: filterType,
                  onChanged: filterPropertiesByType,
                  items: PropertyType.values.map((type) {
                    return DropdownMenuItem<PropertyType>(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ],
            ),
            // DropdownButton<String>(
            //   value: selectedPropertyType,
            //   items: <String>['All', 'Flat', 'Shop'].map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String? value) {
            //     if (value != null) {
            //       if (value == 'All') {
            //         fetchProperties();
            //       } else {
            //         filterPropertiesByType(value);
            //       }
            //     }
            //   },
            // ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterType != null
                  ? filteredProperties.length
                  : properties.length,
              itemBuilder: (BuildContext context, int index) {
                // final property = properties[index];
                Property property = filterType != null
                    ? filteredProperties[index]
                    : properties[index];
                return ListTile(
                  title: Text(property.title),
                  subtitle: Text(property.description),
                  trailing: Text(property.price.toString()),
                  onTap: () {
                    getPropertyById(property.id);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Text(
              'Available Properties:',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                Property property = properties[index];
                return ListTile(
                  title: Text(property.title),
                  subtitle: Text(property.description),
                  // Display other property details
                );
              },
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.refresh),
      //   onPressed: fetchProperties,
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Property'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                    ),
                    // Expanded(
                    //   child: Text(
                    //     'Owner Name:',
                    //     style: TextStyle(fontSize: 16.0),
                    //   ),
                    // ),
                    // DropdownButton<User>(
                    //   value: selectedOwner,
                    //   onChanged: (User? newValue) {
                    //     setState(() {
                    //       selectedOwner = newValue;
                    //     });
                    //   },
                    //   items: users.map((User user) {
                    //     return DropdownMenuItem<User>(
                    //       value: user,
                    //       child: Text(user.name),
                    //     );
                    //   }).toList(),
                    // ),
                    DropdownButtonFormField<User>(
                      value: selectedOwner,
                      onChanged: (User? newValue) {
                        setState(() {
                          selectedOwner = newValue;
                        });
                      },
                      items: users.map((User user) {
                        return DropdownMenuItem<User>(
                          value: user,
                          child: Text(user.name),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Owner',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      addProperty();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
