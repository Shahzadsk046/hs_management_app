import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:housing_society_management/models/committee_member.dart';
import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/nominee.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/vote.dart';
import 'package:housing_society_management/services/election_service.dart';
import 'package:housing_society_management/services/society_service.dart';

class ElectionScreen extends StatefulWidget {
  @override
  _ElectionScreenState createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  final ElectionService _electionService = ElectionService();
  final SocietyService _societyService = SocietyService();
  List<Election> _elections = [];
  List<Society> _societies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchElections();
    _fetchSocieties();
  }

  Future<void> _fetchElections() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final elections = await _electionService.getAllElections();
      setState(() {
        _elections = elections;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch elections.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _fetchSocieties() async {
    try {
      final societies = await _societyService.getAllSocieties();
      setState(() {
        _societies = societies;
      });
    } catch (error) {
      // Handle error
    }
  }

  // Future<void> _createElection(
  //     String title, DateTime startDate, DateTime endDate, int societyId) async {
  //   try {
  //     final election = Election(
  //       id: 0, // ID will be generated automatically
  //       title: title,
  //       startDate: startDate,
  //       endDate: endDate,
  //       societyId: societyId,
  //     );
  //     await _electionService.createElection(election);
  //     _fetchElections();
  //   } catch (error) {
  //     // Handle error
  //   }
  // }

  // Future<void> _createElection(Election election) async {
  //   try {
  //     // Call the createElection method from the ElectionService
  //     await _electionService.createElection(
  //       election.title,
  //       election.startDate,
  //       election.endDate,
  //       election.societyId,
  //     );

  //     // Display a success message or handle any errors
  //     showDialog(
  //       // Existing code...
  //       content: Text('Election created successfully'),
  //       // Existing code...
  //     );
  //   } catch (error) {
  //     // Handle error
  //     showDialog(
  //       // Existing code...
  //       content: Text('Failed to create election'),
  //       // Existing code...
  //     );
  //   }
  // }

  Future<void> _createElection() async {
    // Show a form to input election details
    final election = await showDialog<Election>(
      context: context,
      builder: (ctx) => ElectionFormDialog(),
    );

    if (election != null) {
      try {
        await _electionService.createElection(
          title: election.title,
          startDate: election.startDate,
          endDate: election.endDate,
          societyId: election.societyId,
        );

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election created successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  // Future<void> _updateElection(Election election, String title,
  //     DateTime startDate, DateTime endDate) async {
  //   try {
  //     final updatedElection = Election(
  //       id: election.id,
  //       title: title,
  //       startDate: startDate,
  //       endDate: endDate,
  //       societyId: election.societyId,
  //     );
  //     await _electionService.updateElection(updatedElection);
  //     _fetchElections();
  //   } catch (error) {
  //     // Handle error
  //   }
  // }

  Future<void> _updateElection(Election election) async {
    // Show a form to update election details
    final updatedElection = await showDialog<Election>(
      context: context,
      builder: (ctx) => ElectionFormDialog(election: election),
    );

    if (updatedElection != null) {
      try {
        await _electionService.updateElection(updatedElection);

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election updated successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  // Future<void> _deleteElection(Election election) async {
  //   try {
  //     await _electionService.deleteElection(election.id);
  //     _fetchElections();
  //   } catch (error) {
  //     // Handle error
  //   }
  // }

  Future<void> _deleteElection(Election election) async {
    // Show a confirmation dialog to confirm deletion
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to delete this election?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _electionService.deleteElection(election.id);

        // Refresh the list of elections
        await _fetchElections();

        // Show a success message
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Success'),
            content: Text('Election deleted successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } catch (error) {
        // Handle error
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete election.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  Future<List<CommitteeMember>> _getCommitteeMembersByElectionId(
      int electionId) async {
    try {
      return await _electionService.getCommitteeMembersByElectionId(electionId);
    } catch (error) {
      // Handle error
      return [];
    }
  }

  Future<List<Nominee>> _getNomineesByElectionId(int electionId) async {
    try {
      return await _electionService.getNomineesByElectionId(electionId);
    } catch (error) {
      // Handle error
      return [];
    }
  }

  Future<List<Vote>> _getVotesByElectionId(int electionId) async {
    try {
      return await _electionService.getVotesByElectionId(electionId);
    } catch (error) {
      // Handle error
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elections'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _elections.length,
              itemBuilder: (context, index) {
                final election = _elections[index];
                return ListTile(
                  // title: Text(election.title),
                  // subtitle:
                  //     Text('Start: ${election.startDate} | End: ${election.endDate}'),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     _deleteElection(election);
                  //   },
                  // ),
                  title: Text(election.title),
                  subtitle:
                      Text('Start Date: ${election.startDate.toString()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteElection(election);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _createElection();
          // _showElectionFormDialog();
        },
      ),
    );
  }

  Future<void> _createElection() async {
    try {
      final society = await showDialog<Society>(
        context: context,
        builder: (ctx) => SocietySelectionDialog(),
      );

      if (society != null) {
        final election = await showDialog<Election>(
          context: context,
          builder: (ctx) => ElectionFormDialog(society: society),
        );

        if (election != null) {
          await _electionService.createElection({
            title: election.title,
            startDate: election.startDate,
            endDate: election.endDate,
            societyId: election.societyId,
          });
          await _fetchElections();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Election created successfully')),
          );
        }
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create election.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

//   Future<void> _showElectionFormDialog({Election? election}) async {
//     final isEditing = election != null;
//     final formKey = GlobalKey<FormState>();
//     String title = election?.title ?? '';
//     DateTime startDate = election?.startDate ?? DateTime.now();
//     DateTime endDate = election?.endDate ?? DateTime.now();

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(isEditing ? 'Edit Election' : 'Create Election'),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   initialValue: title,
//                   decoration: InputDecoration(labelText: 'Title'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     title = value ?? '';
//                   },
//                 ),
//                 // Add more form fields for startDate and endDate
//                 // Add the start date field
//                 TextFormField(
//                   initialValue: startDate != null
//                       ? DateFormat.yMd().format(startDate)
//                       : '',
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: 'Start Date',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   onTap: () async {
//                     final selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: startDate ?? DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime(2100),
//                     );
//                     if (selectedDate != null) {
//                       setState(() {
//                         startDate = selectedDate;
//                       });
//                     }
//                   },
//                 ),
//                 // Add the end date field
//                 TextFormField(
//                   initialValue:
//                       endDate != null ? DateFormat.yMd().format(endDate) : '',
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: 'End Date',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   onTap: () async {
//                     final selectedDate = await showDatePicker(
//                       context: context,
//                       initialDate: endDate ?? DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime(2100),
//                     );
//                     if (selectedDate != null) {
//                       setState(() {
//                         endDate = selectedDate;
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   formKey.currentState!.save();
//                   if (isEditing) {
//                     _updateElection(election!, title, startDate, endDate);
//                   } else {
//                     _createElection(title, startDate, endDate);
//                   }
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text(isEditing ? 'Update' : 'Create'),
//             ),
//           ],
//         );
//       },
//     );
  // }
}

class ElectionFormDialog extends StatefulWidget {
  final Election? election;

  ElectionFormDialog({this.election});

  @override
  _ElectionFormDialogState createState() => _ElectionFormDialogState();
}

class _ElectionFormDialogState extends State<ElectionFormDialog> {
  late TextEditingController _titleController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.election?.title);
    _startDateController =
        TextEditingController(text: widget.election?.startDate.toString());
    _endDateController =
        TextEditingController(text: widget.election?.endDate.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final title = _titleController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);

    final updatedElection = Election(
      id: widget.election?.id ?? 0,
      title: title,
      startDate: startDate,
      endDate: endDate,
      societyId: widget.election?.societyId ?? 0,
    );

    Navigator.of(context).pop(updatedElection);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.election == null ? 'Create Election' : 'Update Election'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _startDateController,
            decoration: InputDecoration(labelText: 'Start Date'),
          ),
          TextFormField(
            controller: _endDateController,
            decoration: InputDecoration(labelText: 'End Date'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: _saveForm,
        ),
      ],
    );
  }
}

// class ElectionScreen extends StatefulWidget {
//   final ElectionService electionService = ElectionService();

//   // ElectionScreen({required this.electionService});

//   @override
//   _ElectionScreenState createState() => _ElectionScreenState();
// }

// class _ElectionScreenState extends State<ElectionScreen> {
//   List<Election> _elections = [];
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchElections();
//   }

//   Future<void> _fetchElections() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       List<Election> elections = await widget.electionService.getAllElections();
//       setState(() {
//         _elections = elections;
//       });
//     } catch (error) {
//       // Handle error
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Elections'),
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: _elections.length,
//               itemBuilder: (context, index) {
//                 Election election = _elections[index];
//                 return ListTile(
//                   title: Text(election.title),
//                   subtitle: Text('Start Date: ${election.startDate}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.info),
//                     onPressed: () {
//                       _showElectionDetails(election);
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Future<void> _showElectionDetails(Election election) async {
//     List<CommitteeMember> committeeMembers = await widget.electionService
//         .getCommitteeMembersByElectionId(election.id);
//     List<Nominee> nominees =
//         await widget.electionService.getNomineesByElectionId(election.id);
//     List<Vote> votes =
//         await widget.electionService.getVotesByElectionId(election.id);

//     // Perform business logic or display the details in a dialog
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(election.title),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Start Date: ${election.startDate}'),
//             Text('End Date: ${election.endDate}'),
//             // Display committee members, nominees, and votes
//             // based on the retrieved data
//             Text('Committee Members:'),
//             for (CommitteeMember member in committeeMembers) Text(member.name),
//             Text('Nominees:'),
//             for (Nominee nominee in nominees) Text(nominee.name),
//             Text('Votes:'),
//             for (Vote vote in votes)
//               Text('${vote.voterName}: ${vote.nomineeName}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _createElection() async {
//     try {
//       // Show a form to input election details
//       Election newElection = await showDialog(
//         context: context,
//         builder: (context) => ElectionFormDialog(),
//       );

//       if (newElection != null) {
//         // Call the createElection method from the ElectionService
//         await widget.electionService.createElection(newElection);

//         // Display a success message
//         _showSnackBar('Election created successfully');

//         // Refresh the elections list
//         await _fetchElections();
//       }
//     } catch (error) {
//       // Handle error
//       _showSnackBar('Failed to create election');
//     }
//   }

//   Future<void> _updateElection(Election election) async {
//     try {
//       // Show a form to update election details
//       Election updatedElection = await showDialog(
//         context: context,
//         builder: (context) => ElectionFormDialog(election: election),
//       );

//       if (updatedElection != null) {
//         // Call the updateElection method from the ElectionService
//         await widget.electionService.updateElection(updatedElection);

//         // Display a success message
//         _showSnackBar('Election updated successfully');

//         // Refresh the elections list
//         await _fetchElections();
//       }
//     } catch (error) {
//       // Handle error
//       _showSnackBar('Failed to update election');
//     }
//   }

//   Future<void> _deleteElection(Election election) async {
//     try {
//       // Show a confirmation dialog to confirm deletion
//       bool deleteConfirmed = await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete this election?'),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Delete'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         ),
//       );

//       if (deleteConfirmed) {
//         // Call the deleteElection method from the ElectionService
//         await widget.electionService.deleteElection(election.id);

//         // Display a success message
//         _showSnackBar('Election deleted successfully');

//         // Refresh the elections list
//         await _fetchElections();
//       }
//     } catch (error) {
//       // Handle error
//       _showSnackBar('Failed to delete election');
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   Future<void> _showElectionFormDialog({Election? election}) async {
//     final isEditing = election != null;
//     final formKey = GlobalKey<FormState>();
//     String title = election?.title ?? '';
//     DateTime startDate = election?.startDate ?? DateTime.now();
//     DateTime endDate = election?.endDate ?? DateTime.now();

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(isEditing ? 'Edit Election' : 'Create Election'),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   initialValue: title,
//                   decoration: InputDecoration(labelText: 'Title'),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     title = value ?? '';
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 // Add more form fields for startDate and endDate
//               ],
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   formKey.currentState!.save();
//                   if (isEditing) {
//                     _updateElection(election!, title, startDate, endDate);
//                   } else {
//                     _createElection(title, startDate, endDate);
//                   }
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text(isEditing ? 'Update' : 'Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
