<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HandInAssignment extends Model
{
    use HasFactory;
    protected $guarded = [];
    protected $casts = [
        'file' => 'array',
    ];
    public function Assignment()
    {
        return $this->belongsTo(Assignment::class);
    }
    public function User()
    {
        return $this->belongsTo(User::class);
    }
    public function TempPost()
    {
        return $this->belongsTo(TempPost::class);
    }
}
