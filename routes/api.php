<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);

Route::prefix('users')->group(function () {
    Route::post('/', [UserController::class, 'store'])->name('users.store');
    Route::get('/', [UserController::class, 'index'])->name('users.index');
    Route::get('/{id}', [UserController::class, 'show'])->name('users.show');
    Route::put('/{id}', [UserController::class, 'update'])->name('users.update');
    Route::delete('/{id}', [UserController::class, 'destroy'])->name('users.destroy');
    Route::get('/{id}/associations', [UserController::class, 'getAssociations'])->name('users.associations');
    // Route::get('/{id}/societies', [UserController::class, 'getSocieties'])->name('users.societies');
    // Route::get('/{id}/properties', [UserController::class, 'getProperties'])->name('users.properties');
    // Route::get('/{id}/elections', [UserController::class, 'getElections'])->name('users.elections');
    // Route::get('/{id}/committee-members', [UserController::class, 'getCommitteeMembers'])->name('users.committee-members');


});
