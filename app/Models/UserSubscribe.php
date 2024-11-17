<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserSubscribe extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'subscribe_author_id',
        'follow_author_id',
        'subscribe',
        'follow',
        'updated_at',
        'created_at',
    ];
    protected $attributes = [
        'subscribe' => 0, // 默認值為 0
        'follow' => 0,    // 默認值為 0
    ];
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
    public function Community()
    {
        return $this->belongsTo(Community::class);
    }
    public function AuthorPost()
    {
        return $this->belongsTo(User::class, 'subscribe_author_id', 'id');
    }
    public function AuthorCommunity()
    {
        return $this->belongsTo(User::class, 'follow_author_id', 'id');
    }

}