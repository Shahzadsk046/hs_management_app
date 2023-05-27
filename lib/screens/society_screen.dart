import 'package:flutter/material.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/society_service.dart';

// class SocietyScreen extends StatefulWidget {
//   @override
//   _SocietyScreenState createState() => _SocietyScreenState();
// }

// class _SocietyScreenState extends State<SocietyScreen> {
//   final SocietyService societyService = SocietyService();

//   List<Society> societies = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSocieties();
//   }

//   Future<void> _loadSocieties() async {
//     try {
//       final List<Society> loadedSocieties =
//           await societyService.getAllSocieties();
//       setState(() {
//         societies = loadedSocieties;
//       });
//     } catch (error) {
//       print('Failed to load societies: $error');
//     }
//   }

//   Future<void> _createSociety(Society society) async {
//     try {
//       final Society createdSociety =
//           await societyService.createSociety(society);
//       setState(() {
//         societies.add(createdSociety);
//       });
//     } catch (error) {
//       print('Failed to create society: $error');
//     }
//   }

//   Future<void> _updateSociety(Society society) async {
//     try {
//       final Society updatedSociety =
//           await societyService.updateSociety(society);
//       setState(() {
//         societies = societies
//             .map((s) => s.id == updatedSociety.id ? updatedSociety : s)
//             .toList();
//       });
//     } catch (error) {
//       print('Failed to update society: $error');
//     }
//   }

//   Future<void> _deleteSociety(Society society) async {
//     try {
//       await societyService.deleteSociety(society.id);
//       setState(() {
//         societies.removeWhere((s) => s.id == society.id);
//       });
//     } catch (error) {
//       print('Failed to delete society: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Societies'),
//       ),
//       body: ListView.builder(
//         itemCount: societies.length,
//         itemBuilder: (context, index) {
//           final society = societies[index];
//           return ListTile(
//             title: Text(society.name),
//             subtitle: Text(society.address),
//             onTap: () {
//               // Navigate to SocietyDetailsScreen and pass the society
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showSocietyFormDialog();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> _showSocietyFormDialog(
//       {Society? society, required int adminId, required User admin}) async {
//     final formKey = GlobalKey<FormState>();
//     String name = society?.name ?? '';
//     String address = society?.address ?? '';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(society == null ? 'Create Society' : 'Update Society'),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   initialValue: name,
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the society name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     name = value ?? '';
//                   },
//                 ),
//                 TextFormField(
//                   initialValue: address,
//                   decoration: InputDecoration(labelText: 'Address'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the society address';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     address = value ?? '';
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   formKey.currentState!.save();
//                   Navigator.pop(context);
//                   final updatedSociety = Society(
//                     id: society?.id ?? DateTime.now().millisecondsSinceEpoch,
//                     name: name,
//                     address: address,
//                     adminId: adminId, // Replace with the actual admin ID
//                     admin: admin, // Replace with the actual admin details
//                     properties: society?.properties ?? [],
//                     propertyVariants: society?.propertyVariants ?? [],
//                     expenses: society?.expenses ?? [],
//                   );

//                   if (society == null) {
//                     _createSociety(updatedSociety);
//                   } else {
//                     _updateSociety(updatedSociety);
//                   }
//                 }
//               },
//               child: Text(society == null ? 'Create' : 'Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class SocietyScreen extends StatefulWidget {
  @override
  _SocietyScreenState createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen> {
  final SocietyService _societyService = SocietyService();
  List<Society> _societies = [];

  @override
  void initState() {
    super.initState();
    fetchSocieties();
  }

  Future<void> fetchSocieties() async {
    try {
      final societies = await _societyService.getAllSocieties();
      setState(() {
        _societies = societies;
      });
    } catch (error) {
      // Handle error
    }
  }

  Future<void> createSociety(Society society) async {
    try {
      await _societyService.createSociety(
          society.name, society.address, society.adminId);
      // Refresh the list of societies
      await fetchSocieties();
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Society created successfully')),
      );
    } catch (error) {
      // Handle error
    }
  }

  Future<void> updateSociety(Society society) async {
    try {
      await _societyService.updateSociety(
          society.id, society.name, society.address);
      // Refresh the list of societies
      await fetchSocieties();
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Society updated successfully')),
      );
    } catch (error) {
      // Handle error
    }
  }

  Future<void> deleteSociety(Society society) async {
    try {
      await _societyService.deleteSociety(society.id);
      // Refresh the list of societies
      await fetchSocieties();
      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Society deleted successfully')),
      );
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Societies'),
      ),
      body: ListView.builder(
        itemCount: _societies.length,
        itemBuilder: (context, index) {
          final society = _societies[index];
          return ListTile(
            title: Text(society.name),
            subtitle: Text(society.address),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateSocietyDialog(society),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteSociety(society),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showCreateSocietyDialog(),
      ),
    );
  }

  Future<void> _showCreateSocietyDialog() async {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String address = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Society'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the society name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the society address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    address = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.pop(context);
                  final newSociety = Society(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: name,
                    address: address,
                    adminId: 1, // Replace with actual admin ID
                    admin: null, // Replace with actual admin details
                    properties: [],
                    propertyVariants: [],
                    expenses: [],
                  );
                  createSociety(newSociety);
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUpdateSocietyDialog(Society society) async {
    final formKey = GlobalKey<FormState>();
    String name = society.name;
    String address = society.address;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Society'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the society name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value ?? '';
                  },
                ),
                TextFormField(
                  initialValue: address,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the society address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    address = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  Navigator.pop(context);
                  final updatedSociety = Society(
                    id: society.id,
                    name: name,
                    address: address,
                    adminId: society.adminId,
                    admin: society.admin,
                    properties: society.properties,
                    propertyVariants: society.propertyVariants,
                    expenses: society.expenses,
                  );
                  updateSociety(updatedSociety);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
