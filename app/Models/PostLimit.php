<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PostLimit extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [];
    public function User()
    {
        return $this->belongsTo(User::class);
    }
}
