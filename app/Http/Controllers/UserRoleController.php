<?php

namespace App\Http\Controllers;

use App\Models\UserRole;
use Illuminate\Http\Request;

class UserRoleController extends Controller
{
    public function index()
    {
        $roles = UserRole::all();
        return response()->json($roles);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:user_roles',
        ]);

        $role = UserRole::create([
            'name' => $request->name,
        ]);

        return response()->json($role, 201);
    }

    public function show(UserRole $role)
    {
        return response()->json($role);
    }

    public function update(Request $request, UserRole $role)
    {
        $request->validate([
            'name' => 'required|string|unique:user_roles,name,' . $role->id,
        ]);

        $role->update([
            'name' => $request->name,
        ]);

        return response()->json($role);
    }

    public function destroy(UserRole $role)
    {
        $role->delete();
        return response()->json(['message' => 'Role deleted']);
    }
}
