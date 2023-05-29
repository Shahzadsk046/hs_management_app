<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Society;
use App\Models\Property;
use App\Models\Election;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();
        return response()->json([
            'status' => 'success',
            'data' => $users
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6',
            'phone' => 'required|',
            'role' => 'required|string',
            // Add any additional validation rules as per your requirements
        ]);

        // $user = User::create($validatedData);
        $user = new User();
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->password = bcrypt($request->input('password'));
        $user->phone = $request->input('phone');
        $user->role = $request->input('role');
        $user->save();

        return response()->json($user, 201);
    }

    public function show($id)
    {
        // Find the user by ID
        $user = User::findOrFail($id);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Return the user
        return response()->json($user);
    }

    public function update(Request $request, $id)
    {
        // Find the user by ID
        $user = User::findOrFail($id);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $validatedData = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email,' . $id,
            'phone' => 'required|string',
            'role' => 'required|string',
            // Add any additional validation rules as per your requirements
        ]);

        $user->update($validatedData);

        return response()->json($user);
    }

    public function destroy($id)
    {
        // Find the user by ID
        $user = User::findOrFail($id);

        $user->delete();
        return response()->json(['message' => 'User deleted Successfully']);
    }

    /**
     * Get the societies associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getSocieties($userId)
    {
        $user = User::findOrFail($userId);
        $societies = $user->society;

        return response()->json(['societies' => $societies]);
    }

    /**
     * Get the properties associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getProperties($userId)
    {
        $user = User::findOrFail($userId);
        $properties = $user->properties;

        return response()->json(['properties' => $properties]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\Response
     */
    // public function getElections($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $elections = $user->elections;

    //     return response()->json(['elections' => $elections]);
    // }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getElections($userId)
    {
        $user = User::findOrFail($userId);
        $elections = $user->elections;

        return response()->json(['elections' => $elections]);
    }

    /**
     * Get the committee members associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCommitteeMembers($userId)
    {
        $user = User::findOrFail($userId);
        $committeeMembers = $user->committeeMembers;

        return response()->json(['committeeMembers' => $committeeMembers]);
    }

    // /**
    //  * Get the nominees associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getNominees($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $nominees = $user->nominees;

    //     return response()->json(['nominees' => $nominees]);
    // }

    // /**
    //  * Get the votes associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getVotes($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $votes = $user->votes;

    //     return response()->json(['votes' => $votes]);
    // }

    // /**
    //  * Get the poll votes associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getPollVotes($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $pollVotes = $user->pollVotes;

    //     return response()->json(['pollVotes' => $pollVotes]);
    // }

    // /**
    //  * Get the events associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getEvents($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $events = $user->events;

    //     return response()->json(['events' => $events]);
    // }

    // /**
    //  * Get the parking lots associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getParkingLots($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $parkingLots = $user->parkingLots;

    //     return response()->json(['parkingLots' => $parkingLots]);
    // }

    // /**
    //  * Get the maintenance charges associated with a user.
    //  *
    //  * @param int $userId
    //  * @return \Illuminate\Http\JsonResponse
    //  */
    // public function getMaintenanceCharges($userId)
    // {
    //     $user = User::findOrFail($userId);
    //     $maintenanceCharges = $user->maintenanceCharges;

    //     return response()->json(['maintenanceCharges' => $maintenanceCharges]);
    // }

    public function getAssociations($id)
    {
        // Find the user by ID
        $user = User::findOrFail($id);

        // Retrieve the associated data
        $associations = [
            'societies' => $user->societies,
            'properties' => $user->properties,
            'elections' => $user->elections,
            'committeeMembers' => $user->committeeMembers,
            'nominees' => $user->nominees,
            'votes' => $user->votes,
            'pollVotes' => $user->pollVotes,
            'events' => $user->events,
            'parkingLots' => $user->parkingLots,
            'maintenanceCharges' => $user->maintenanceCharges,
        ];

        // Return the associations
        return response()->json($associations);
    }
}
