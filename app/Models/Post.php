<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [];
    public function User()
    {
        return $this->belongsTo(User::class);
    }
    public function UvaTopic()
    {
        return $this->belongsTo(UvaTopic::class);
    }
    public function Comment()
    {
        return $this->hasMany(Comment::class);
    }
    public function UserLike()
    {
        return $this->hasMany(UserLike::class);
    }

    public function UserCollect()
    {
        return $this->hasMany(UserCollect::class);
    }
    public function HandInAssignment()
    {
        return $this->hasMany(HandInAssignment::class);
    }
}
