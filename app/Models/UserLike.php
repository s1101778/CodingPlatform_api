<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserLike extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'post_id',
		'community_id',
        'comment_id',
        'dislike_or_like',
        'updated_at', 
        'created_at',
    ];
    protected $attributes = [
        'dislike_or_like' => 0, // 默認值為 0
    ];
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function Comment()
    {
        return $this->belongsTo(Comment::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
	
	
	public function Community()
    {
        return $this->belongsTo(Community::class);
    }
}
