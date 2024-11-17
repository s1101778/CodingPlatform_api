<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tags extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [];
    public function Comment_User()
    {
        return $this->belongsTo(User::class,'comment_user_id','id');
    }
    public function Taged_User()
    {
        return $this->belongsTo(User::class,'Taged_user_id','id');
    }
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function Community()
    {
        return $this->belongsTo(Community::class);
    }

}
