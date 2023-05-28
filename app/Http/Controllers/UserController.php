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
        return response()->json($users);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6',
            'phone' => 'required|string',
            'role' => 'required|exists:user_roles,id',
            // Add any additional validation rules as per your requirements
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'phone' => $request->phone,
            'role' => $request->role,
            // Add any additional fields as per your user model
        ]);

        return response()->json($user, 201);
    }

    public function show(User $user)
    {
        return response()->json($user);
    }

    public function update(Request $request, User $user)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'phone' => 'required|string',
            'role' => 'required|exists:user_roles,id',
            // Add any additional validation rules as per your requirements
        ]);

        $user->update([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'role' => $request->role,
            // Update any additional fields as per your user model
        ]);

        return response()->json($user);
    }

    public function destroy(User $user)
    {
        $user->delete();
        return response()->json(['message' => 'User deleted']);
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
     * Get the elections associated with a user.
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

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getNominees($userId)
    {
        $user = User::findOrFail($userId);
        $nominees = $user->nominees;

        return response()->json(['nominees' => $nominees]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getVotes($userId)
    {
        $user = User::findOrFail($userId);
        $votes = $user->votes;

        return response()->json(['votes' => $votes]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getPollVotes($userId)
    {
        $user = User::findOrFail($userId);
        $pollVotes = $user->pollVotes;

        return response()->json(['pollVotes' => $pollVotes]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getEvents($userId)
    {
        $user = User::findOrFail($userId);
        $events = $user->events;

        return response()->json(['events' => $events]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getParkingLots($userId)
    {
        $user = User::findOrFail($userId);
        $parkingLots = $user->parkingLots;

        return response()->json(['parkingLots' => $parkingLots]);
    }

    /**
     * Get the elections associated with a user.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getMaintenanceCharges($userId)
    {
        $user = User::findOrFail($userId);
        $maintenanceCharges = $user->maintenanceCharges;

        return response()->json(['maintenanceCharges' => $maintenanceCharges]);
    }
}
