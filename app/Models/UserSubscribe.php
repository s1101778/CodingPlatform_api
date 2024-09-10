<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserSubscribe extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'author_id',
        'subscribe',
        'updated_at',
        'created_at',
    ];
    protected $attributes = [
        'subscribe' => 0, // 默認值為 0
    ];
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
}
