<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [];
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
    public function UserLike()
    {
        return $this->hasMany(UserLike::class);
    }
    public function Community()
    {
        return $this->belongsTo(Community::class);
    }
}