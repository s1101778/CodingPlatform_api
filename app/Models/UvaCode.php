<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UvaCode extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function Post()
    {
        return $this->hasMany(Post::class);
    }
    public static function get_uva_code_id($serial)
    {
        $result = UvaCode::where('serial', $serial)->first()->id;
        return $result;
    }
}
