<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Community extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [];
    public function User()
    {
        return $this->belongsTo(User::class);
    }
    // public function UserSubscribe()
    // {
    //     return $this->hasMany(UserSubscribe::class, 'author_id', 'id');
    // }
    public function Comment()
    {
        return $this->hasMany(Comment::class);
    }

    // public function UserLike()
    // {
    //     return $this->hasMany(UserLike::class);
    // }
    // public function PostView()
    // {
    //     return $this->hasMany(PostView::class);
    // }
    // public function HandInAssignment()
    // {
    //     return $this->hasMany(HandInAssignment::class);
    // }
}