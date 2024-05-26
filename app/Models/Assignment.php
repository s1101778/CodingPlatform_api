<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Assignment extends Model
{
    protected $guarded = [];
    protected $casts = [
        'file' => 'array',
    ];
    use HasFactory;
    public function CodingClass()
    {
        return $this->belongsTo(CodingClass::class);
    }
    public function Post()
    {
        return $this->hasMany(Post::class);
    }
    public function HandInAssignment()
    {
        return $this->hasMany(HandInAssignment::class);
    }
    public function getTeacherClass_Teacher_user_id()
    {
        return $this->CodingClass->TeacherClass_Teacher->first()->user_id;
    }
    public function getTeacherClass_TA_user_ids()
    {
        return $this->CodingClass->TeacherClass_TA->pluck('user_id');
    }
    public function getUserClass_user_ids()
    {
        return $this->CodingClass->UserClass->pluck('user_id');
    }
}
