<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class UvaCodeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $file_path = resource_path('sql/UvaCode.sql');
        DB::table('uva_codes')->truncate();
        DB::unprepared(file_get_contents($file_path));
    }
}