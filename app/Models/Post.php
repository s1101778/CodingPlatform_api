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
    public function UvaCode()
    {
        return $this->belongsTo(UvaCode::class);
    }
    public function Comment()
    {
        return $this->hasMany(Comment::class);
    }
    public function UserLike()
    {
        return $this->hasMany(UserLike::class);
    }
    public function PostView()
    {
        return $this->hasMany(PostView::class);
    }
    public function HandInAssignment()
    {
        return $this->hasMany(HandInAssignment::class);
    }
}
