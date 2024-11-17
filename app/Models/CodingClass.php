<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CodingClass extends Model
{
    protected $guarded = [];
    protected $casts = [];
    use HasFactory;
    public function Assignment()
    {
        return $this->hasMany(Assignment::class);
    }
    public function UserClass()
    {
        return $this->hasMany(UserClass::class);
    }
    public function TeacherClass()
    {
        return $this->hasMany(TeacherClass::class);
    }
    public function TeacherClass_Teacher()
    {
        return $this->hasMany(TeacherClass::class)->where('user_type', 1);
    }
    public function TeacherClass_TA()
    {
        return $this->hasMany(TeacherClass::class)->where('user_type', 2);
    }
    public function getTeacherClass_Teacher_user_id()
    {
        return $this->TeacherClass_Teacher->first()->user_id;
    }
    public function getTeacherClass_TA_user_ids()
    {
        return $this->TeacherClass_TA->pluck('user_id');
    }
    public function getUserClass_user_ids()
    {
        return $this->UserClass->pluck('user_id');
    }
}
