<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TeacherClass extends Model
{
    protected $guarded = [];
    protected $casts = [];
    use HasFactory;
    public function CodingClass()
    {
        return $this->belongsTo(CodingClass::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
}
