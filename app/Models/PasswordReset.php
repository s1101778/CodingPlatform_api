<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PasswordReset extends Model
{
    use HasFactory;
    protected $primaryKey = 'email';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $table = 'password_reset_tokens';
    protected $casts = [];
    protected $fillable = [
        'email',
        'token',
        'created_at',
    ];
}
