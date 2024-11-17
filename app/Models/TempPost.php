<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TempPost extends Model
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
    public function Post()
    {
        return $this->belongsTo(Post::class);
    }
    public function Assignment()
    {
        return $this->belongsTo(Assignment::class);
    }
}
