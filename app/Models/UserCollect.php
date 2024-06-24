<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserCollect extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'post_id',
        'collect',
        'updated_at',
        'created_at',
    ];
    protected $attributes = [
        'collect' => 0, // 默認值為 0
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
