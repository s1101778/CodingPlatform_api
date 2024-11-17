<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

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
        'account',
        'email',
        'password',
        'subscriptions',
        'follows',
        'remember_token',
        'picture',
        'cover',
        'intro',
        'github',
        'isadmin'
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
    ];
    public function Post()
    {
        return $this->hasMany(Post::class);
    }
    public function Community()
    {
        return $this->hasMany(Community::class);
    }
    public function Note()
    {
        return $this->hasMany(Note::class);
    }
    public function UserLike()
    {
        return $this->hasMany(UserLike::class);
    }
    public function UserSubscribe()
    {
        return $this->hasMany(UserSubscribe::class);
    }
    public function SubscribeAuthor()
    {
        return $this->hasMany(UserSubscribe::class, 'subscribe_author_id');
    }
    public function FollowAuthor()
    {
        return $this->hasMany(UserSubscribe::class, 'follow_author_id');
    }
    public function PostView()
    {
        return $this->hasMany(PostView::class);
    }
    public function Taged()
    {
        return $this->hasMany(Tags::class, 'Taged_user_id', 'id');
    }
    public function UserClass()
    {
        return $this->hasMany(UserClass::class);
    }
    public function TeacherClass()
    {
        return $this->hasMany(TeacherClass::class);
    }
    public function HandInAssignment()
    {
        return $this->hasMany(HandInAssignment::class);
    }
    public function PostLimit()
    {
        return $this->hasMany(PostLimit::class);
    }
}