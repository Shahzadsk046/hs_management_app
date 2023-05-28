<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string',
            'email' => 'required|string|email|unique:users,email',
            'password' => 'required|string|min:8',
            'phone' => 'required|string',
            'role' => 'required|string',
        ]);

        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => bcrypt($validatedData['password']),
            'phone' => $validatedData['phone'],
            'role' => $validatedData['role']
        ]);

        // $user->userRole()->associate($validatedData['user_role']);
        $user->save();

        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json(['message' => 'User registered successfully', 'user' => $user, 'token' => $token]);
    }

    public function login(Request $request)
    {
        // $credentials = $request->validate([
        //     'email' => 'required|string|email',
        //     'password' => 'required|string',
        // ]);

        $validatedData = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('email', 'password');

        if (!Auth::attempt($credentials)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        // $user = User::where('email', $validatedData['email'])->first();

        // if (!$user || !bcrypt::check($validatedData['password'], $user->password)) {
        //     throw ValidationException::withMessages([
        //         'email' => ['The provided credentials are incorrect.'],
        //     ]);
        // }

        $user = auth()->user();
        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json(['message' => 'User authenticated successfully', 'user' => $user, 'role' => $user->role, 'token' => $token]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Logged out']);
    }
}
