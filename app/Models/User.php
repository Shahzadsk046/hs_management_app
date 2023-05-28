<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'role',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    // public function role()
    // {
    //     return $this->belongsTo(UserRole::class, 'role');
    // }
    public function properties()
    {
        return $this->hasMany(Property::class);
    }

    public function elections()
    {
        return $this->hasMany(Election::class);
    }

    public function committeeMembers()
    {
        return $this->hasMany(CommitteeMember::class);
    }

    public function nominees()
    {
        return $this->hasMany(Nominee::class);
    }

    public function votes()
    {
        return $this->hasMany(Vote::class);
    }

    public function pollVotes()
    {
        return $this->hasMany(PollVote::class);
    }

    public function events()
    {
        return $this->hasMany(Event::class);
    }

    public function parkingLots()
    {
        return $this->hasMany(ParkingLot::class);
    }

    public function maintenanceCharges()
    {
        return $this->hasMany(MaintenanceCharge::class);
    }

    public function society()
    {
        return $this->belongsTo(Society::class);
    }

    // public function userRole()
    // {
    //     return $this->belongsTo(UserRole::class);
    // }
}
